# AI Task Generator

A Rails 8 application that leverages OpenAI's ChatGPT API to automatically generate detailed task lists based on user-defined goals. Users can create accounts, set goals, and receive AI-generated actionable task breakdowns to help achieve their objectives.

## Features

- **User Authentication**: Secure user registration and login powered by Devise
- **AI-Powered Task Generation**: Integration with OpenAI's ChatGPT API to generate detailed task lists
- **Task Management**: Create, edit, update, delete, and mark tasks as complete
- **Task Search**: Search functionality to find specific tasks
- **User Profiles**: Personal user profiles with customizable settings
- **Slack Integration**: Notification system for task updates
- **Rate Limiting**: Built-in protection against API abuse using Rack::Attack
- **Responsive Design**: Modern, mobile-friendly interface

## Technology Stack

- **Backend**: Ruby 3.3.4, Rails 8.0.1
- **Database**: MySQL 2 (with SQLite3 for development/test)
- **Authentication**: Devise
- **Frontend**: Turbo, Stimulus, Importmap
- **Styling**: CSS with modern responsive design
- **API Integration**: HTTParty for OpenAI API calls
- **Background Jobs**: Solid Queue
- **Caching**: Solid Cache
- **WebSockets**: Solid Cable
- **Containerization**: Docker & Docker Compose
- **Testing**: RSpec, Capybara, Selenium
- **Security**: Brakeman, Rack::Attack
- **Code Quality**: RuboCop Rails Omakase

## Prerequisites

- Ruby 3.3.4
- Rails 8.0.1
- MySQL (for production) or SQLite3 (for development)
- Docker & Docker Compose (optional)
- OpenAI API key

## Installation & Setup

### Local Development

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd AI-Task-Generator
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Environment Configuration**
   Create a `.env` file in the root directory with the following variables:
   ```env
   OPENAI_BASE_URI=https://api.openai.com/v1
   OPENAI_API_KEY=your_openai_api_key_here
   OPENAI_API_MODEL=gpt-3.5-turbo
   DATABASE_URL=mysql2://root:password@localhost:3306/take_home_dev
   ```

4. **Database Setup**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. **Start the server**
   ```bash
   rails server
   ```

   The application will be available at `http://localhost:3000`

### Docker Development

1. **Build and start services**
   ```bash
   docker-compose up --build
   ```

2. **Setup database**
   ```bash
   docker-compose exec app rails db:create
   docker-compose exec app rails db:migrate
   docker-compose exec app rails db:seed
   ```

## Configuration

### OpenAI API Setup

1. Sign up for an OpenAI account at https://platform.openai.com/
2. Generate an API key from your OpenAI dashboard
3. Add the API key to your environment variables as shown above
4. Ensure you have sufficient API credits for your usage

### Database Configuration

The application supports both MySQL (production) and SQLite3 (development/test):

- **Development**: Uses SQLite3 by default for easy local development
- **Production**: Configured for MySQL with connection pooling and proper encoding
- **Test**: Uses SQLite3 for fast test execution

### Slack Integration (Optional)

To enable Slack notifications, configure the Slack initializer with your webhook URL and credentials.

## Usage

### Creating Tasks Manually

1. Register for an account or log in
2. Navigate to "New Task"
3. Fill in the task title and description
4. Save the task

### AI-Generated Tasks

1. Navigate to "Generate Task" 
2. Enter your goal (e.g., "Learn to play guitar", "Start a fitness routine")
3. The AI will generate a detailed, step-by-step task list
4. Review and save the generated tasks

### Managing Tasks

- **View Tasks**: See all your tasks on the main dashboard
- **Search Tasks**: Use the search functionality to find specific tasks
- **Complete Tasks**: Mark tasks as completed when finished
- **Edit/Delete**: Modify or remove tasks as needed

## API Endpoints

The application includes several key routes:

- `GET /tasks` - List all user tasks
- `POST /tasks` - Create a new task
- `GET /tasks/generate` - Show AI task generation form
- `POST /tasks/generate` - Generate tasks using AI
- `GET /tasks/search` - Search tasks
- `GET /tasks/:id/complete` - Mark task as complete
- `GET /profile` - User profile management

## Testing

### Running the Test Suite

```bash
# Run all tests
bundle exec rspec

# Run specific test files
bundle exec rspec spec/services/chatgpt_service_spec.rb

# Run with coverage
bundle exec rspec --format documentation
```

### Test Structure

- **Models**: Unit tests for Task and User models
- **Controllers**: Integration tests for all controllers
- **Services**: Comprehensive tests for AI integration services
- **System**: End-to-end browser tests using Capybara

## Security

The application implements several security measures:

- **Rate Limiting**: Rack::Attack prevents API abuse
- **Input Validation**: All user inputs are validated and sanitized
- **Authentication**: Secure user authentication with Devise
- **CSRF Protection**: Built-in Rails CSRF protection
- **Security Scanning**: Brakeman for static security analysis

## Deployment

### Using Kamal (Recommended)

The application is configured for deployment using Kamal:

```bash
# Deploy to production
kamal deploy

# Check deployment status
kamal app logs
```

### Manual Deployment

1. Set up production environment variables
2. Configure production database
3. Precompile assets: `rails assets:precompile`
4. Run migrations: `rails db:migrate RAILS_ENV=production`
5. Start the application server

## Development

### Code Style

The project uses RuboCop with Rails Omakase configuration:

```bash
# Check code style
bundle exec rubocop

# Auto-fix issues
bundle exec rubocop -a
```

### Security Scanning

```bash
# Run security scan
bundle exec brakeman
```

### Adding New Features

1. Create feature branch from main
2. Implement changes with tests
3. Run test suite and security scans
4. Submit pull request

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes with appropriate tests
4. Ensure all tests pass and code style is maintained
5. Submit a pull request

## Troubleshooting

### Common Issues

1. **OpenAI API Errors**
   - Verify API key is correct and has sufficient credits
   - Check internet connectivity
   - Ensure API model is available

2. **Database Connection Issues**
   - Verify database configuration in `config/database.yml`
   - Ensure database server is running
   - Check credentials and permissions

3. **Asset Issues**
   - Run `rails assets:precompile` for production
   - Clear browser cache
   - Check importmap configuration

### Logs

Application logs are available in:
- Development: `log/development.log`
- Production: Check your deployment platform's logging system

## License

This project is available as open source under the terms of the [MIT License](LICENSE).

## Support

For support, please create an issue in the GitHub repository or contact the development team.
