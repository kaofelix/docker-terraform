# docker-terraform

Run [terraform](https://github.com/hashicorp/terraform) from a docker container.
Includes [terraform-provider-mongodbatlas](https://github.com/akshaykarle/terraform-provider-mongodbatlas).

Based on [docker-autostacker](https://github.com/felixb/docker-autostacker)

## Usage

Run the container like this:

```bash
docker run \
    -v "${PWD}:/workdir:ro" \         # <-- this mounts your current directory inside the container's work dir
    -v "${HOME}/.aws:/.aws:ro" \      # <-- this mounts your aws credentials inside the container's home dir
    -e AWS_PROFILE=some-aws-profile \ # <-- choose your aws profile
    kaofelix/terraform \
    apply                             # <-- run any terraform command
```

You might want to add the following function to your `.bashrc` or similar to allow even easier usage:

```bash
function terraform() {
    docker run \
        --rm \
        -v "${PWD}:/workdir:ro" \
        -v "${HOME}/.aws:/.aws:ro" \
        -e "AWS_PROFILE=${AWS_PROFILE}" \
        -e "AWS_REGION=${AWS_REGION}" \
        kaofelix/terraform \
        "${@}"
}
```
