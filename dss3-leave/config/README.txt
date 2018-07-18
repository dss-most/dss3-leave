# ต้องทำการ install ojdbc14.jar jthaipdf.jar และ thai-font.jar ลงใน local maven repository ก่อน โดยใช้ คำสั่ง

-- ojdbc14-10.2.0.1.0.jar

mvn install:install-file -Dfile=<path-to-file>/ojdbc14-10.2.0.1.0.jar -DgroupId=com.oracle \
    -DartifactId=ojdbc14 -Dversion=10.2.0.1.0 -Dpackaging=jar 
    
    
-- jthaipdf-1.0.1.jar

mvn install:install-file -Dfile=<path-to-file>/jthaipdf-1.0.1.jar -DgroupId=th.go.dss.pdf \
    -DartifactId=jthaipdf -Dversion=1.0.1 -Dpackaging=jar 
    
-- thai-font-1.0.pdf

mvn install:install-file -Dfile=<path-to-file>/thai-font-1.0.jar -DgroupId=th.go.dss.pdf \
    -DartifactId=thai-font -Dversion=1.0 -Dpackaging=jar 
    