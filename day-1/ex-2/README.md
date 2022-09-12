# Exercise 2

Following steps must be executed on your local computer.

## Installation and configuration of VSCode

1. Download and install VSCode : https://code.visualstudio.com/
2. Search and install the extension called [Kubernetes](https://marketplace.visualstudio.com/items?itemName=ms-kubernetes-tools.vscode-kubernetes-tools)
3. Explore the new menu item on the left vertical bar
4. Open the current repository in VSCode and go to day-1/ex-2/deployment.yaml
4. Fix suggested change (warning) using inline documentation and completion
5. Deploy the descriptor using "Kubernetes: Apply" command (ctrl+shift+p)


## Live coding with Skaffold

1. Install the binary version of Skaffold available here: https://skaffold.dev/docs/install/#standalone-binary
2. Go to day-1/ex-2/skaffold directory and type `skaffold init`
3. Look at generated skaffold.yaml file
4. Run `skaffold dev` to launch the deployment in watch mode
5. You can open your browser by typing `minikube service nginx-svc`
5. Change the content of index.html and watch how Skaffold reacts, reload the web page

