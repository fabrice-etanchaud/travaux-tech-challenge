FROM postgres:9.6-buster
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=travaux
ADD . /
RUN apt-get update -yq && \
apt-get install software-properties-common -yq && \
apt-get update -yq && \
apt-get install wget -yq && \
wget -c https://github.com/embulk/embulk/releases/download/v0.9.23/embulk-0.9.23.jar -O /embulk/embulk.jar && \
wget https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public -O - | apt-key add - && \
add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
apt-get update -yq && apt-get install adoptopenjdk-8-hotspot -yq && \
java -jar /embulk/embulk.jar gem install embulk-output-postgresql && \
apt-get install git libpq-dev python-dev python3-pip -yq && \
pip3 install --upgrade pip && \
apt-get remove python-cffi -yq && \
pip3 install --upgrade cffi && \
pip3 install cryptography~=3.4 && \
pip3 install dbt && \
wget -c https://downloads.metabase.com/v0.39.4/metabase.jar -O /metabase/metabase.jar
