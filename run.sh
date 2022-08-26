docker container rm -f miniconda_container
docker run -d \
        --gpus all \
        -p 2522:22 \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/group:/etc/group:ro \
        -v /mnt/pool1/at/workspace:/home/${USER} \
        --name miniconda_container miniconda_img

