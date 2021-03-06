# Please refer to the documentation:
# https://cloud.google.com/migrate/anthos/docs/dockerfile-reference

FROM anthos-migrate.gcr.io/v2k-run-embedded:v1.7.5 as migrate-for-anthos-runtime

# Image containing data captured from the source VM
FROM gcr.io/ishmeetm/py-app-instance-non-runnable-base:5-24-2021--2-39-43 as source-content

# If you want to update parts of the image, add your commands here.
# For example:
# RUN apt-get update
# RUN apt-get install -y \
#		package1=version \
#		package2=version \
#		package3=version
# RUN yum update
# RUN wget http://github.com

COPY --from=migrate-for-anthos-runtime / /

ADD blocklist.yaml /.m4a/blocklist.yaml

# Migrate for Anthos image includes entrypoint
ENTRYPOINT [ "/.v2k.go" ]