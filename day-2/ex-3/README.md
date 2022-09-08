# Exercise 3

In this exercise, you will create a persistent volume claim and reference that claim in an nginx pod.
You will write content to the persistent volume, then delete the pod.

Then, you will check you retrieve the written content if you create an other pod with the same reference to the PVC.

Finally, you will deploy MariaDB instances through a statefulset and see how the data is managed and the consequences.


# Deploy an nginx pod

## See the storage Classes

```sh
kubectl get storageClass
kubectl describe storageClass [name storageClass]
```

## Create a Persistent Volume Claim to ask a 2Gi R/W storage

Here is the claim declaration:
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```

Declare the claim (be careful, the provided `.yaml` file may be incorrect....)
```sh
kubectl apply -f pv-claim.yaml
```

Do you see a persistent volume automatically created ?
```sh
kubectl get pv
```

Why?

## Create a pod which references the Persistent Volume Claim

Here is the pod spec:
```
kind: Pod
apiVersion: v1
metadata:
  name: task-pv-pod
spec:
  volumes:
    - name: task-pv-storage
      persistentVolumeClaim:
       claimName: task-pv-claim
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: task-pv-storage
```

Create the pod:
```sh
kubectl apply -f pv-pod.yaml
```

## Write content to the persistent volume

You should get a pv and a pod:
```
kubectl get pv,pod -o wide
```

Now, write content to the persistent volume:
```
kubectl exec -it task-pv-pod -- bash
echo 'K8s rules!' > /usr/share/nginx/html/index.html
curl http://localhost
```


## Delete the pod and recreate it

Run the kubectl commands to delete the pod.
Then create-it again.

Check the index.html file still exists.

## Bonus: force the pod to be created on another node

Note the worker node which hosts the pod.
Then delete the task-pv-pod pod.

Edit the `.yaml` file and use the `nodeName` field in the spec to indicate another worker node.

Apply the changes.

Is it possible?

# Deploy a MariaDB statefulset

Deploy three MariaDB instances using the `statefulset-mariadb.yaml` file

How many persistent volumes are created ? Why ? What is their characteristic ?

Connect to the `mariadb-sts-0` pod and connect to the database (there is a password for the root user somewhere)

Create a database, a table and insert some data in it
```
CREATE DATABASE wsc_training;
USE wsc_training;
CREATE TABLE Trainees (Id MEDIUMINT NOT NULL AUTO_INCREMENT, FirstName VARCHAR(255), LastName VARCHAR(255), PRIMARY KEY (Id));
INSERT INTO Trainees (FirstName, LastName) VALUES ("MyFirstName", "MyLastName");

# Check that the data has correctly been inserted
SELECT * FROM Trainees;
```

Delete the `mariadb-sts-0`, reconnect to the mysql database and check that the database is still there

Now connect to the `mariadb-sts-1` pod and look for the data. Is it there ? Why ?

What is the solution to avoid this ?


# Clean
```
kubectl delete po task-pv-pod
kubectl delete sts mariadb-sts
kubectl delete --all pvc
```