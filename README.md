
 <br/>
 <div align="center">
 <a href="https://github.com/ShaanCoding/ReadME-Generator">
 <img src="https://i.postimg.cc/L8xnb2R3/temp-Image0gs-HUZ.avif" alt="Logo" width="80" height="80">
 </a>
 <h3 align="center">Bloggy (Flutter Blog App)</h3>
 <p align="center">
 Where words come to life!
 
 </p>
 </div>
 # Flutter Blog Application

This is a simple blog application built using Flutter, focusing on the implementation of Clean Architecture, Supabase for backend services, Get It for service locator, FP Dart, and Bloc for state management.

 
 ![Product Screenshot](https://i.postimg.cc/L6N9HD7H/Simulator-Screenshot-i-Phone-15-Pro-Max-2024-05-25-at-15-59-33.png)
 ![Product Screenshot](https://i.postimg.cc/FR04LVHn/Simulator-Screenshot-i-Phone-15-Pro-Max-2024-05-25-at-16-48-12.png)


## Features

- **Authentication**: Users can sign up and sign in to the application.
- **Blog Creation**: Authenticated users can create new blog posts with a title, content, and an accompanying image.
- **Blog Listing**: All blog posts are displayed in a feed-like interface, accessible to both authenticated users.
- **Blog Details**: Users can view the details of a specific blog post, including the title, content, and the associated image.



## Architecture

This application follows the principles of Clean Architecture, which helps to separate the concerns of the application and make it more maintainable and testable. The main layers of the architecture are:

1. **Presentation Layer**: This layer contains the UI components, such as pages, widgets, and bloc/cubit implementations.
2. **Domain Layer**: This layer contains the core business logic, including use cases, entities, and repositories.
3. **Data Layer**: This layer handles the data-related operations, such as interacting with the Supabase backend and local data sources.

The application also utilizes the following additional architectural patterns and tools:

- **Service Locator (Get It)**: Used for dependency injection and managing the lifecycle of dependencies.
- **Functional Programming (FP Dart)**: Leverages FP concepts, such as immutable data and higher-order functions, to write concise and expressive code.
- **Bloc State Management**: Implements the Bloc pattern for managing the state of the application.

## Technologies Used

- **Flutter**: The primary framework used for building the mobile application.
- **Supabase**: A comprehensive backend solution for the application, providing authentication and database services.
- **Get It**: A dependency injection and service locator library for Flutter.
- **Bloc**: A state management library that follows the Bloc pattern.

## Installation and Setup

1. Clone the repository
2. Install dependencies
3. Set up Supabase:
   - Create a new Supabase project.
   - Copy the project URL and API key and update the `supabase_url` and `supabase_key` constants in the `lib/core/` folder.
4. Run the application

## Contributing

If you find any issues or have suggestions for improvements, feel free to open a new issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
