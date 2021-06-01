//package com.micro.service.springkafka.config;
//
//import lombok.extern.slf4j.Slf4j;
//import org.apache.kafka.clients.consumer.ConsumerConfig;
//import org.apache.kafka.clients.producer.ProducerConfig;
//import org.apache.kafka.common.serialization.StringDeserializer;
//import org.apache.kafka.common.serialization.StringSerializer;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.kafka.annotation.EnableKafka;
//import org.springframework.kafka.config.ConcurrentKafkaListenerContainerFactory;
//import org.springframework.kafka.config.KafkaListenerContainerFactory;
//import org.springframework.kafka.core.*;
//import org.springframework.kafka.listener.ConcurrentMessageListenerContainer;
//import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
//
//import java.util.HashMap;
//import java.util.Map;
//import java.util.concurrent.Executor;
//
///**
//* @Description
//* @Author zxl
//* @Date  2020-10-29  09:07:43
//**/
//@Configuration
//@EnableKafka
//@Slf4j
//public class KafkaConfig {
//
//    @Bean
//    public Executor Acknowledgment () {
//        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
//        executor.setCorePoolSize(10);
//        executor.setMaxPoolSize(200);
//        executor.setQueueCapacity(10);
//        executor.initialize();
//        return executor;
//    }
//
//    /**
//     * send default template
//     */
//    @Bean
//    public ProducerFactory<Integer, String> producerFactory() {
//        DefaultKafkaProducerFactory factory = new DefaultKafkaProducerFactory<>(producerConfigs());
//        return factory;
//    }
//    @Bean
//    public Map<String,Object> producerConfigs(){
//        Map<String,Object> props = new HashMap<>(3);
//        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG,"192.168.24.45:9092");
//        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
//        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG,StringSerializer.class);
//        return props;
//    }
//
//    @Bean
//    public KafkaTemplate<Integer, String> kafkaTemplate(){
//        KafkaTemplate template = new KafkaTemplate<Integer, String>(producerFactory());
//        return template;
//    }
//
//
//    @Bean
//    public ConsumerFactory<Integer, String> consumerFactory() {
//        return new DefaultKafkaConsumerFactory<>(consumerConfigs());
//    }
//
//    @Bean
//    public Map<String, Object> consumerConfigs() {
//        Map<String, Object> props = new HashMap<>(3);
//        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, "192.168.24.45:9092");
//        props.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);
//        props.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG,StringDeserializer.class);
//        return props;
//    }
//
//    @Bean
//    public KafkaListenerContainerFactory<ConcurrentMessageListenerContainer<Integer, String>>
//    kafkaListenerContainerFactory() {
//        ConcurrentKafkaListenerContainerFactory<Integer, String> factory =
//                new ConcurrentKafkaListenerContainerFactory<>();
//        factory.setConsumerFactory(consumerFactory());
//        factory.setConcurrency(3);
//        factory.getContainerProperties().setPollTimeout(3000);
//        factory.setBatchListener(true);
//        return factory;
//    }
//
//}
