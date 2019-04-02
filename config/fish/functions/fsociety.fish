function fsociety
	set working_dir (pwd)
	git clone https://github.com/Manisso/fsociety ~/.fsociety
	cd ~/.fsociety
	docker-compose build
	docker-compose up -d
	docker-compose exec fsociety fsociety
	cd "$working_dir"
end
