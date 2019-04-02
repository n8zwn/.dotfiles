function fsociety
	set working_dir (pwd)
	cd ~/.fsociety
	docker-compose down
	cd "$working_dir"
end
