# Exercise 4

## Install Helm 3 and try it


- Install Helm: https://helm.sh/docs/intro/install/
- Create a new Chart => simpleApp. Use Helm commands
- Can you browse through all the  generated files : templates, values ... and try to understand how it works ? 
- What is the default project in the chart helm ? 
=> nginx
- Install the application. And voila you have an application up and running in the kubernetes cluster. Check it out.
- Checkout the revision, version saved by Helm and using Helm API.
- Clean up this installation using helm commands


##  Develop a new chart

The objective of this exercise is to migrate an application from k8s to Helm yaml descriptors.
This is a simple two-thirds application: frontend and backend. We will use our Chart twice: one instance for backend and the other for the frontend.

The steps are:
1. Copy the given `backend-*.yaml` files inside the templates directory of the provided `simpleapp` chart
2. Modify the `yaml` files to use templating capabilities from the helpers. You can use the `helm template` command to test the rendering. What must be templated:
    1. labels
    1. resource names
    1. image name of the container (see values.yaml)
3. Install a release of this chart
4. Test connectivity
5. See how NOTES.txt describes how to test the application


## Reuse and enhance an existing chart

Now we want to install a second instance of your chart to deploy the equivalent of frontend-*.yaml descriptors.
You can see that there are very few differences.

The steps are:

1. Create a second values file to overload what is different from default values
1. Customize your chart to add environment variables


## Clean

```sh
helm uninstall simpleapp-backend simpleapp-frontend
```
