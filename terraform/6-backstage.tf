resource "kubectl_manifest" "backstage-namespace" {
  count = var.enable_backstage ? 1 : 0

  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: backstage
YAML
}

# kubernetes/postgres-secrets.yaml
resource "kubectl_manifest" "postgress-secrets" {
  count = var.enable_backstage ? 1 : 0

  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: postgres-secrets
  namespace: backstage
type: Opaque
data:
  POSTGRES_USER: YmFja3N0YWdl
  POSTGRES_PASSWORD: YmFja3N0YWdl
YAML

}

# kubernetes/postgres-storage.yaml
resource "kubectl_manifest" "postgress-storage" {
  count = var.enable_backstage ? 1 : 0

  yaml_body = <<YAML
apiVersion: v1
kind: PersistentVolume
metadata:
  name: postgres-storage
  namespace: backstage
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 2G
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: '/mnt/data'
YAML

}

resource "kubectl_manifest" "postgress-pvc" {
  count = var.enable_backstage ? 1 : 0

  yaml_body = <<YAML
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-storage-claim
  namespace: backstage
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2G
YAML

}

# kubernetes/postgres.yaml
resource "kubectl_manifest" "postgress" {
  count = var.enable_backstage ? 1 : 0

  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
  namespace: backstage
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: postgres:13.2-alpine
          imagePullPolicy: 'IfNotPresent'
          ports:
            - containerPort: 5432
          envFrom:
            - secretRef:
                name: postgres-secrets
          volumeMounts:
            - mountPath: /var/lib/postgresql/data
              name: postgresdb
      volumes:
        - name: postgresdb
          persistentVolumeClaim:
            claimName: postgres-storage-claim
YAML

}

# kubernetes/postgres-service.yaml
resource "kubectl_manifest" "postgress-service" {
  count = var.enable_backstage ? 1 : 0

  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: postgres
  namespace: backstage
spec:
  selector:
    app: postgres
  ports:
    - port: 5432
YAML

}

# kubernetes/backstage-secrets.yaml
resource "kubectl_manifest" "backstage-secrets" {
  count = var.enable_backstage ? 1 : 0

  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: backstage-secrets
  namespace: backstage
type: Opaque
data:
  GITHUB_TOKEN: Z2hwX0h3VUI5NXZEMEZ1Z2dUa0ZEZVhlU1RlVVNmWHluNzN1VzJtTw==
YAML

}

resource "kubectl_manifest" "backstage" {
  count = var.enable_backstage ? 1 : 0

  yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backstage
  namespace: backstage
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backstage
  template:
    metadata:
      labels:
        app: backstage
    spec:
      containers:
        - name: backstage
          image: jingood2/backstage:v0.4.0
          imagePullPolicy: IfNotPresent
          ports:
            - name: http
              containerPort: 7000
          envFrom:
            - secretRef:
                name: postgres-secrets
            - secretRef:
                name: backstage-secrets
YAML

  depends_on = [ kubectl_manifest.backstage-secrets  ]

}

resource "kubectl_manifest" "backstage-service" {
  count = var.enable_backstage ? 1 : 0

  yaml_body = <<YAML
apiVersion: v1
kind: Service
metadata:
  name: backstage
  namespace: backstage
spec:
  selector:
    app: backstage
  ports:
    - name: http
      port: 80
      targetPort: http
YAML

}
