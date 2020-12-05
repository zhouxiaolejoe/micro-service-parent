/*
 *      Copyright (c) 2018-2028, DreamLu All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *  Redistributions of source code must retain the above copyright notice,
 *  this list of conditions and the following disclaimer.
 *  Redistributions in binary form must reproduce the above copyright
 *  notice, this list of conditions and the following disclaimer in the
 *  documentation and/or other materials provided with the distribution.
 *  Neither the name of the dreamlu.net developer nor the names of its
 *  contributors may be used to endorse or promote products derived from
 *  this software without specific prior written permission.
 *  Author: DreamLu 卢春梦 (596392912@qq.com)
 */

package com.micro.service.tool.until.beancopy;


import org.springframework.asm.ClassVisitor;
import org.springframework.asm.Label;
import org.springframework.asm.Type;
import org.springframework.beans.BeanUtils;
import org.springframework.cglib.core.*;
import org.springframework.util.ClassUtils;
import org.springframework.util.StringUtils;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.security.ProtectionDomain;
import java.util.HashMap;
import java.util.Map;


/**
 * spring cglib 魔改
 * @author
 */
public  class PigeonBeanCopier {
	private static final PigeonBeanCopier.BeanCopierKey KEY_FACTORY = (PigeonBeanCopier.BeanCopierKey)KeyFactory.create(PigeonBeanCopier.BeanCopierKey.class);
	private static final Type CONVERTER = TypeUtils.parseType("org.springframework.cglib.core.Converter");
	private static final Type BEAN_COPIER = TypeUtils.parseType(PigeonBeanCopier.class.getName());
	private static final Signature COPY = new Signature("copy", Type.VOID_TYPE, new Type[]{Constants.TYPE_OBJECT, Constants.TYPE_OBJECT, CONVERTER});
	private static final Signature CONVERT = TypeUtils.parseSignature("Object convert(Object, Class, Object)");

	public static PigeonBeanCopier create(Class source, Class target, boolean useConverter) {
		return PigeonBeanCopier.create(source, target, useConverter, false);
	}

	public static PigeonBeanCopier create(Class source, Class target, boolean useConverter, boolean nonNull) {
		Generator gen = new Generator();
			gen.setSource(source);
			gen.setTarget(target);
			gen.setUseConverter(useConverter);
			gen.setNonNull(nonNull);
			return gen.create();
	}


	public void copy(Object from, Object to, Converter converter) {}

	public static class Generator extends AbstractClassGenerator {
		private static final Source SOURCE = new Source(PigeonBeanCopier.class.getName());
		private Class source;
		private Class target;
		private boolean useConverter;
		private boolean nonNull;

		Generator() {
			super(SOURCE);
		}

		public void setSource(Class source) {
			if (!Modifier.isPublic(source.getModifiers())) {
				setNamePrefix(source.getName());
			}
			this.source = source;
		}

		public void setTarget(Class target) {
			if (!Modifier.isPublic(target.getModifiers())) {
				setNamePrefix(target.getName());
			}
			this.target = target;
		}

		public void setUseConverter(boolean useConverter) {
			this.useConverter = useConverter;
		}

		public void setNonNull(boolean nonNull) {
			this.nonNull = nonNull;
		}

		@Override
		protected ClassLoader getDefaultClassLoader() {
			return target.getClassLoader();
		}

		@Override
		protected ProtectionDomain getProtectionDomain() {
			return ReflectUtils.getProtectionDomain(source);
		}

		@Override
		public PigeonBeanCopier create(Object key) {
			return (PigeonBeanCopier) super.create(key);
		}
		public PigeonBeanCopier create() {
			Object key = PigeonBeanCopier.KEY_FACTORY.newInstance(this.source.getName(), this.target.getName(), this.useConverter);
			return (PigeonBeanCopier)super.create(key);
		}
		@Override
		public void generateClass(ClassVisitor v) {
			Type sourceType = Type.getType(source);
			Type targetType = Type.getType(target);
			ClassEmitter ce = new ClassEmitter(v);
			ce.begin_class(Constants.V1_2,
				Constants.ACC_PUBLIC,
				getClassName(),
				BEAN_COPIER,
				null,
				Constants.SOURCE_FILE);

			EmitUtils.null_constructor(ce);
			CodeEmitter e = ce.begin_method(Constants.ACC_PUBLIC, COPY, null);
			PropertyDescriptor[] getters = ReflectUtil.getBeanGetters(source);
			PropertyDescriptor[] setters = ReflectUtil.getBeanSetters(target);
			Map<String, PropertyDescriptor> names = new HashMap<>(16);
			for (PropertyDescriptor getter : getters) {
				names.put(getter.getName(), getter);
			}

			Local targetLocal = e.make_local();
			Local sourceLocal = e.make_local();
			e.load_arg(1);
			e.checkcast(targetType);
			e.store_local(targetLocal);
			e.load_arg(0);
			e.checkcast(sourceType);
			e.store_local(sourceLocal);

			for (PropertyDescriptor setter : setters) {
				String propName = setter.getName();
				CopyProperty targetIgnoreCopy = ReflectUtil.getAnnotation(target, propName, CopyProperty.class);
				if (targetIgnoreCopy != null) {
					if (targetIgnoreCopy.ignore()) {
						continue;
					}
					String aliasTargetPropName = targetIgnoreCopy.value();
					if (StringUtils.hasText(aliasTargetPropName)) {
						propName = aliasTargetPropName;
					}
				}
				PropertyDescriptor getter = names.get(propName);
				if (getter == null) {
					continue;
				}

				MethodInfo read = ReflectUtils.getMethodInfo(getter.getReadMethod());
				Method writeMethod = setter.getWriteMethod();
				MethodInfo write = ReflectUtils.getMethodInfo(writeMethod);
				Type returnType = read.getSignature().getReturnType();
				Type setterType = write.getSignature().getArgumentTypes()[0];
				Class<?> getterPropertyType = getter.getPropertyType();
				Class<?> setterPropertyType = setter.getPropertyType();

				Label l0 = e.make_label();
				if (ClassUtils.isAssignable(getterPropertyType, setterPropertyType)) {
					e.load_local(targetLocal);
					e.load_local(sourceLocal);
					e.invoke(read);
					boolean getterIsPrimitive = getterPropertyType.isPrimitive();
					boolean setterIsPrimitive = setterPropertyType.isPrimitive();

					if (nonNull) {
						e.box(returnType);
						Local var = e.make_local();
						e.store_local(var);
						e.load_local(var);
						e.ifnull(l0);
						e.load_local(targetLocal);
						e.load_local(var);
						e.unbox_or_zero(setterType);
					} else {
						if (getterIsPrimitive && !setterIsPrimitive) {
							e.box(returnType);
						}
						if (!getterIsPrimitive && setterIsPrimitive) {
							e.unbox_or_zero(setterType);
						}
					}
					invokeWrite(e, write, writeMethod, nonNull, l0);
				} else if (useConverter) {
					e.load_local(targetLocal);
					e.load_arg(2);
					e.load_local(sourceLocal);
					e.invoke(read);
					e.box(returnType);

					if (nonNull) {
						Local var = e.make_local();
						e.store_local(var);
						e.load_local(var);
						e.ifnull(l0);
						e.load_local(targetLocal);
						e.load_arg(2);
						e.load_local(var);
					}

					EmitUtils.load_class(e, setterType);
					e.push(propName);
					e.invoke_interface(CONVERTER, CONVERT);
					e.unbox_or_zero(setterType);

					invokeWrite(e, write, writeMethod, nonNull, l0);
				}
			}
			e.return_value();
			e.end_method();
			ce.end_class();
		}

		private static void invokeWrite(CodeEmitter e, MethodInfo write, Method writeMethod, boolean nonNull, Label l0) {
			Class<?> returnType = writeMethod.getReturnType();
			e.invoke(write);
			if (!returnType.equals(Void.TYPE)) {
				e.pop();
			}
			if (nonNull) {
				e.visitLabel(l0);
			}
		}

		@Override
		protected Object firstInstance(Class type) {
			return BeanUtils.instantiateClass(type);
		}

		@Override
		protected Object nextInstance(Object instance) {
			return instance;
		}
	}
	interface BeanCopierKey {
		Object newInstance(String var1, String var2, boolean var3);
	}
}
