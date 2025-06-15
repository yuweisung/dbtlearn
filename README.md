Welcome to my dbt learn project!

### Howe to use this project
## Pre-requisites
* uv
  - install uv
  - run `uv sync`
  - `source .venv/bin/activate`
* multipass 
  - Install multipass
  - Launch an instance `multipass launch --name postgres --cpus 4 --disk 20G --memory 8G`
  - Shell into the instance `multipass shell postgres`
  - Install postgres 17
    ```
    sudo apt install -y postgresql-common
    sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
    sudo apt install -y postgresql postgresql-server-dev
    ```
  - Setup postgresql
    ```
    create user ysung createdb with encrypted password 'changeme';
    create database airbnb owner ysung;
    alter system set listen_addresses = '*';
    #restart postgresql
    systemctl restart postgresql
    #modify pg_hba adding multipass instance ip
    # host airbnb ysung 192.168.64.0/24 scram-sha-256
    select pg_reload_conf();
    
    ```
  - Load raw data
    ```
    wget https://dbtlearn.s3.amazonaws.com/hosts.csv
    wget https://dbtlearn.s3.amazonaws.com/reviews.csv
    wget https://dbtlearn.s3.amazonaws.com/listings.csv
    psql -U ysung -W -h postgres 
    create table raw.raw_listings(id int, listing_url text, name text, room_type text, minimum_nights int, host_id int, price text, created_at text, updated_at text);
    \copy raw.raw_listings(id,listing_url,name,room_type,minimum_nights,host_id,price,created_at,updated_at) from './listings.csv' DELIMITER ',' CSV HEADER
    create table raw.raw_reviews(listing_id int, date text, reviewer_name text,comments text, sentiment text);
    \copy raw.raw_reviews(listing_id,date,reviewer_name,comments,sentiment) from './reviews.csv' DELIMITER ',' CSV HEADER;
    create table raw.raw_hosts(id int, name text, is_superhost text, created_at text, updated_at text);
    \copy raw.raw_hosts(id,name,is_superhost,created_at,updated_at) from './hosts.csv' delimiter ',' csv header;
    ```
## Install dbt and profile
Next step, git clone the project into the uv project, then install dbt-core and dbt-postgres.
```
git clone <repo>
pip install dbt-core dbt-postgres
```
In $User home, create a .dbt folder with a profile.yml file. This profile is scanned by dbt cli for db connection detail. 
  ```
  mkdir ~/.dbt
  cat > ~/.dbt/profile.yml <<EOF
  dbtlearn:
    outputs:
      dev:
        dbname: airbnb
        host: 192.168.64.7
        pass: <changeme>
        port: 5432
        schema: dev
        threads: 4
        type: postgres
        user: ysung
  EOF

  ```
You can git clone this repo and run dbt debug.
```
dbt deps
dbt debugs
```
## Try running the following commands:
- dbt run
- dbt test
