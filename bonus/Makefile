all:
	./scripts/setup.sh

pass_argo:
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

pass_git:
	kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -ojsonpath='{.data.password}' | base64 --decode; echo

clean:
	kubectl delete namespace argocd && kubectl delete namespace dev && kubectl delete namespace gitlab

fclean: clean
	k3d cluster delete argo-cmarouf

.PHONY: all pass_argo pass_git clean fclean complete
