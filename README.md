Для начала нужно убедиться, что установлены:
  - docker
  - java 8
  - wget
  - tar

1. Запустить контейнер с oracle
```
cd oracle
docker build -t oracle_school_emias .
docker run -p 8080:8080 -p 1521:1521 oracle_school_emias
```

2. Скачать maven версия 3.6.3
```
wget https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar xzvf apache-maven-3.6.3-bin.tar.gz
sudo mv apache-maven-3.6.3/ /opt
sudo update-alternatives --install /usr/bin/mvn mvn /opt/apache-maven-3.6.3/ 3063
```

3. Редактировать `deploy-school.sh` - установить путь к исходникам в значение переменной `EMIAS_SCHOOL_SRC`

4. Запустить `deploy-school.sh`
