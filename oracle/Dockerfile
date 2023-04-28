FROM alanpeng/oracledatabase-11g-r2-ee
RUN chmod a+x /entrypoint.sh
ADD initdb.sql /oracle.init.d/

EXPOSE 1521
EXPOSE 8080
