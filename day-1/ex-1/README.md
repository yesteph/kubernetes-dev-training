# Exercise 1

Following steps must be executed on your local computer.

## Installation of Podman

1. Go to https://podman.io/getting-started/installation#installing-on-linux and follow installation steps
2. Find the command to launch a Pod using pod.yaml description file
    1. There is one thing to fix in the description file
    2. Hint: Which registry is accessible by default?

Questions:
3. Where is launched the corresponding container?
4. How do you display corresponding logs?

## Installation of Minikube

1. Go to https://minikube.sigs.k8s.io/docs/start/ and follow from step 1 to 3
2. Type `docker ps` and explain what is running
3. Type `kubectl get nodes` to check how is distributed your cluster
4. Launch a Pod with the image hello-world once (without restart) using one command line
5. Deploy the preceding pod.yaml file

Questions:
3. Where is launched the corresponding container?
4. How do you display corresponding logs?

