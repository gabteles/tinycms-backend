# frozen_string_literal: true

Dependencies = Dry::Container.new
Dependencies.register(:google_repository, -> { GoogleHttpRepository.new })

Inject = Dry::AutoInject(Dependencies)
