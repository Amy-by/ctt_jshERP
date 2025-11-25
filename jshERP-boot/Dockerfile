# 基础镜像
FROM openjdk:8-jre-alpine

# 工作目录
WORKDIR /app

# 复制打包好的 JAR 文件（需先本地打包：mvn clean package -Dmaven.test.skip=true）
COPY target/jshERP-boot-1.0.jar app.jar

# 暴露后端端口
EXPOSE 9999

# 启动命令（指定配置文件，方便外部挂载修改）
CMD ["java", "-jar", "app.jar", "--spring.profiles.active=prod"]
