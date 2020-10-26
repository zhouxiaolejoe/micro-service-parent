package com.micro.service.springquartz.config;

import org.springframework.context.annotation.Configuration;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
@Configuration
public class MyClassLoader extends ClassLoader {
	/**
	 * 需要加载类的路径
	 */
	private String classPath;

	public MyClassLoader() {
	}

	public MyClassLoader(String classPath) {
		super();
		this.classPath = classPath;
	}

	@Override
	protected Class<?> findClass(String name) throws ClassNotFoundException {
		Class<?> clazz = null;
		// 获取class文件字节码数组
		byte[] clazzByteArr = getData();

		if (clazzByteArr != null) {
			// 将class的字节码数组转换成class类的实例
			clazz = defineClass(name, clazzByteArr, 0, clazzByteArr.length);
		}
		return clazz;
	}

	/**
	 * 获取class文件字节数组
	 * 
	 * @return
	 */
	private byte[] getData() {
		File file = new File(this.classPath);
		if (file.exists()) {
			FileInputStream in = null;
			ByteArrayOutputStream out = null;
			try {
				in = new FileInputStream(file);
				out = new ByteArrayOutputStream();

				byte[] buffer = new byte[1024];
				int size = 0;
				while ((size = in.read(buffer)) != -1) {
					out.write(buffer, 0, size);
				}

			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			return out.toByteArray();
		} else {
			return null;
		}
	}

	public String getClassPath() {
		return classPath;
	}

	public void setClassPath(String classPath) {
		this.classPath = classPath;
	}

}
