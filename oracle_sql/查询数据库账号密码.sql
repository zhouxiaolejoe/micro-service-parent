SELECT t.username||'/'||t.password||REPLACE(t.url,'jdbc:oracle:thin:','') from fasp_t_syncdatabase t;
