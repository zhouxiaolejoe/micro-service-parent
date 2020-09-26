package com.micro.service.springquartz.mybatis.typehandler;

import oracle.sql.TIMESTAMP;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;
import sun.misc.BASE64Encoder;

import java.lang.reflect.Method;
import java.sql.*;
import java.text.SimpleDateFormat;

public class TimestampTypeHandler implements TypeHandler<TIMESTAMP> {
    /**
     * 此typlehandler只针对新增
     */
    @Override
    public void setParameter(PreparedStatement ps, int i, TIMESTAMP parameter, JdbcType jdbcType) throws SQLException {
        /**
         * 转换Oracle timestamp 转换为 java.sql的timestamp
         */
        ps.setTimestamp(i,getOracleTimestamp(parameter));
    }

    @Override
    public TIMESTAMP getResult(ResultSet rs, String columnName) throws SQLException {
        return null;
    }

    @Override
    public TIMESTAMP getResult(ResultSet rs, int columnIndex) throws SQLException {
        return null;
    }

    @Override
    public TIMESTAMP getResult(CallableStatement cs, int columnIndex) throws SQLException {
        return null;
    }


    /**
     * ORACLE TIMESTAMP to String
     */
    private String getStringValue(Object obj) {
        if (null == obj) {
            return "";
        } else if (obj instanceof byte[]) {
            return new BASE64Encoder().encode((byte[]) obj);
        } else if (obj instanceof oracle.sql.TIMESTAMP) {
            Timestamp timestamp = getOracleTimestamp(obj);
            String time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(timestamp);
            return time;
        }
        return obj.toString();
    }
    /**
     * oracle.sql.timestamp to java.sql.timestamp
     */
    private Timestamp getOracleTimestamp(Object value) {
        try {
            Class clz = value.getClass();
            Method method = clz.getMethod("timestampValue", new Class[0]);
            return (Timestamp) method.invoke(value, new Class[0]);
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
}