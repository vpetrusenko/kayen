# Kayen CI Documentation

## Login to concourse
```
fly -t ci login -n TEAM_NAME -c CONCOURSE_URL
```


## Create or update a pipeline
```
fly -t ci set-pipeline -p kayen -c /pipelines/review.yml -n
```
