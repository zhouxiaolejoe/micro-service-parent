package com.micro.service.gateway.routing.dynamic.controller;

import com.alibaba.fastjson.JSON;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.cloud.gateway.actuate.GatewayControllerEndpoint;
import org.springframework.cloud.gateway.event.RefreshRoutesEvent;
import org.springframework.cloud.gateway.filter.FilterDefinition;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.cloud.gateway.filter.factory.GatewayFilterFactory;
import org.springframework.cloud.gateway.handler.predicate.PredicateDefinition;
import org.springframework.cloud.gateway.handler.predicate.RoutePredicateFactory;
import org.springframework.cloud.gateway.route.RouteDefinition;
import org.springframework.cloud.gateway.route.RouteDefinitionLocator;
import org.springframework.cloud.gateway.route.RouteDefinitionWriter;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.support.NameUtils;
import org.springframework.cloud.gateway.support.NotFoundException;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.context.ApplicationEventPublisherAware;
import org.springframework.core.Ordered;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.net.URI;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/route")
public class CustomGatewayControllerEndpoint implements ApplicationEventPublisherAware {

    private static final Log log = LogFactory.getLog(GatewayControllerEndpoint.class);

    protected RouteDefinitionLocator routeDefinitionLocator;

    protected List<GlobalFilter> globalFilters;

    // TODO change casing in next major release
    protected List<GatewayFilterFactory> GatewayFilters;

    protected List<RoutePredicateFactory> routePredicates;

    protected RouteDefinitionWriter routeDefinitionWriter;

    protected RouteLocator routeLocator;

    protected ApplicationEventPublisher publisher;

    public CustomGatewayControllerEndpoint(
            RouteDefinitionLocator routeDefinitionLocator,
            List<GlobalFilter> globalFilters, List<GatewayFilterFactory> gatewayFilters,
            List<RoutePredicateFactory> routePredicates,
            RouteDefinitionWriter routeDefinitionWriter, RouteLocator routeLocator) {
        this.routeDefinitionLocator = routeDefinitionLocator;
        this.globalFilters = globalFilters;
        this.GatewayFilters = gatewayFilters;
        this.routePredicates = routePredicates;
        this.routeDefinitionWriter = routeDefinitionWriter;
        this.routeLocator = routeLocator;
    }

    @Override
    public void setApplicationEventPublisher(ApplicationEventPublisher publisher) {
        this.publisher = publisher;
    }

    // TODO: Add uncommited or new but not active routes endpoint

    @PostMapping("/refresh")
    public Mono<Void> refresh() {
        this.publisher.publishEvent(new RefreshRoutesEvent(this));
        return Mono.empty();
    }

    @GetMapping("/globalfilters")
    public Mono<HashMap<String, Object>> globalfilters() {
        return getNamesToOrders(this.globalFilters);
    }

    @GetMapping("/routefilters")
    public Mono<HashMap<String, Object>> routefilers() {
        return getNamesToOrders(this.GatewayFilters);
    }

    @GetMapping("/routepredicates")
    public Mono<HashMap<String, Object>> routepredicates() {
        return getNamesToOrders(this.routePredicates);
    }

    private <T> Mono<HashMap<String, Object>> getNamesToOrders(List<T> list) {
        return Flux.fromIterable(list).reduce(new HashMap<>(), this::putItem);
    }

    private HashMap<String, Object> putItem(HashMap<String, Object> map, Object o) {
        Integer order = null;
        if (o instanceof Ordered) {
            order = ((Ordered) o).getOrder();
        }
        // filters.put(o.getClass().getName(), order);
        map.put(o.toString(), order);
        return map;
    }

    /*
     * http POST :8080/admin/gateway/routes/apiaddreqhead uri=http://httpbin.org:80
     * predicates:='["Host=**.apiaddrequestheader.org", "Path=/headers"]'
     * filters:='["AddRequestHeader=X-Request-ApiFoo, ApiBar"]'
     */
    @PostMapping("/routes/{id}")
    @SuppressWarnings("unchecked")
    public Mono<ResponseEntity<Object>> save(@PathVariable String id,
                                             @RequestBody RouteDefinition route) {
        return Mono.just(route).filter(this::validateRouteDefinition)
                .flatMap(routeDefinition -> this.routeDefinitionWriter
                        .save(Mono.just(routeDefinition).map(r -> {
                            r.setId(id);
                            log.debug("Saving route: " + route);
                            return r;
                        }))
                        .then(Mono.defer(() -> Mono.just(ResponseEntity
                                .created(URI.create("/routes/" + id)).build()))))
                .switchIfEmpty(
                        Mono.defer(() -> Mono.just(ResponseEntity.badRequest().build())));
    }

    private boolean validateRouteDefinition(RouteDefinition routeDefinition) {
        boolean hasValidFilterDefinitions = routeDefinition.getFilters().stream()
                .allMatch(filterDefinition -> GatewayFilters.stream()
                        .anyMatch(gatewayFilterFactory -> filterDefinition.getName()
                                .equals(gatewayFilterFactory.name())));

        boolean hasValidPredicateDefinitions = routeDefinition.getPredicates().stream()
                .allMatch(predicateDefinition -> routePredicates.stream()
                        .anyMatch(routePredicate -> predicateDefinition.getName()
                                .equals(routePredicate.name())));
        log.debug("FilterDefinitions valid: " + hasValidFilterDefinitions);
        log.debug("PredicateDefinitions valid: " + hasValidPredicateDefinitions);
        return hasValidFilterDefinitions && hasValidPredicateDefinitions;
    }

    @DeleteMapping("/routes/{id}")
    public Mono<ResponseEntity<Object>> delete(@PathVariable String id) {
        return this.routeDefinitionWriter.delete(Mono.just(id))
                .then(Mono.defer(() -> Mono.just(ResponseEntity.ok().build())))
                .onErrorResume(t -> t instanceof NotFoundException,
                        t -> Mono.just(ResponseEntity.notFound().build()));
    }

    @GetMapping("/routes/{id}/combinedfilters")
    public Mono<HashMap<String, Object>> combinedfilters(@PathVariable String id) {
        // TODO: missing global filters
        return this.routeLocator.getRoutes().filter(route -> route.getId().equals(id))
                .reduce(new HashMap<>(), this::putItem);
    }
}
