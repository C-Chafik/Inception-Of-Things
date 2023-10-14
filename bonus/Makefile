all:
	./scripts/setup.sh

install:
	./scripts/setup_env.sh

pass:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

clean:
	kubectl delete namespace argocd && kubectl delete namespace dev && kubectl delete namespace gitlab

fclean: clean
	k3d cluster delete argo-cmarouf

.PHONY: all install pass clean fclean
