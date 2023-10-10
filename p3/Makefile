all:
	./scripts/setup.sh

pass:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

clean:
	kubectl delete namespace argocd && kubectl delete namespace dev

fclean: clean
	k3d cluster delete argo-cmarouf

.PHONY: all pass clean fclean
