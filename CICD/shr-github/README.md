# Postmortum
This solution is made in Pareto Principle.

# Backup

### Terraform - > we can store tfstate on different bucket[s3], FTP server , any storage in different place. Why ? Easy to widraw.
### Kubernetes Templates - > I used my own templates, i could/should use helm charts. Current souluton its IaC we can storage it in different buck[s3]≤ FTP sever , any storage.
### #DB - >  it's bad pratice for deploy postgres as Deployment / StateFull but I don't want to pay for DBAS. In DBAS solution snapshots, pq_dumps. In current solution Copy pv values on storage/s3 , snapshots of pv.
