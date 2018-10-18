jar file /mnt/artefact/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar:
  file.managed:
    - name: /mnt/artefact/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar
    - source: salt://mnt/artefact/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar
    - user: root
    - group: root
    - mode: 0660

 cmd.run:
     - name: |
        java -jar  spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar
     - cwd: /mnt/artefact
     - shell: /bin/bash


