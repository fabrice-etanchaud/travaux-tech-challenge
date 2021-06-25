# travaux-tech-challenge

## [travaux.com](https://travaux.com)  technical challenge

This work is based on :
- [embulk](https://www.embulk.org/) for the Extract/Load steps : configuration can be found in the `/embulk/` directory
- postgres for storage and SQL fueling
- [dbt](https://www.getdbt.com) for Transformation : project will be found under `dbt/travaux/`

## Docker usage

### Building the tech challenge environment

Thanks to the repository's [Dockerfile](Dockerfile), one can build the tech challenge environment like this :

    docker build -t travaux-tech-challenge .
Please be patient...

### Running the tech challenge environment
The built environment can be launched with the following command line :

    docker run -d -p 5432:5432 -p 8080:8080 -p 3000:3000 travaux-tech-challenge

Then, please get the running container id like this :

    docker ps
and launch a terminal session in the environment with this container-id :

    sudo docker exec -it CONTAINER-ID bash
We are now going to use this terminal to process our data.

### Extrat/Load the event_log data with embulk
This will extract the data from the event_log.csv file and load it in the postgres instance :

    cd /embulk
    java -jar embulk.jar run event_log.yml
### Transform data with dbt
Now, we can use dbt to transform the data, from the event_log data up to the end user's datasets :

    cd /dbt/travaux
    dbt run --profiles-dir .

### Test tranformation steps with dbt

The following command will validate all the transformation steps :

    dbt test --profiles-dir .

### Navigate the transformations' documentation

To learn how data is transformed, one can follow these steps :

 1. Generate the documentation : `dbt docs generate --profiles-dir .`
 2. Start the embedded dbt web server : `dbt docs serve --profiles-dir . &`
 3. Open a web browser at `http://localhost:8080`

### Explore the end user's datasets

Finally, we can explore the data further in a data visualization tool :

 1. `cd /metabase`
 2. `java -jar metabase.jar &`
 3. Open a web browser page at `http://localhost:3000`
 4. Authenticate with the following parameters : `fabrice.etanchaud@netc.fr` / `travaux1`

### Stop the environment

    docker stop CONTAINER-ID

### Thank you !
*This Dockerfile is the first one I have ever built, and it may surely not follow the best practices...*
