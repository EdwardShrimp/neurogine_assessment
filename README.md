# Neurogine Catalog App (Flutter)

This is a catalog app that load a lists of products in a listing page, where user can also search through the catalog, and opens a product details page when the product is clicked through the listing page.

## How to run

The app can be run by downloading the apk file attached in the google drive link. If prefer to not download as apk, or doesn't have an Android mobile device, can run the app via Visual Studio Code.

If decided to run the app via Visual Studio Code, it is required to run the app in:

- Flutter SDK that includes Dart `3.8` or newer (`environment.sdk` is `^3.8.1`)

## App flow

The app starts with a normal splash screen. By tapping the button "Go To Catalog", a catalog listing screen will open. Scroll to the bottom will have more items loaded. Tap a product to open the product detail screen. User can search specific products through the search field at the top of the catalog listing page.

## Architecture Decision

- **Feature-first project structure.** It is easier to debug as I know immediately what folder to look for if a certain page has bug/error.
- **Bloc.** The reason of using Bloc instead of something I much familiar with (GetX) is because Bloc are more widely used, and Bloc has much stable support compare to GetX.
- **One shared HTTP client.** Repositories only call one HTTP Client instead of keep creating new instance for each repository
- **Empty search restores the loaded list.** When user clicked the clear button or search button with empty text field, the initial list will be loaded instaed of showing empty list.
- **Splash Screen.** Though not really used in this particular project, I decided to implement a Splash Screen anyway to showcase the importance of it, as a Splash Screen can show something for user (Latest news/upgrade/images) while the app runs neccessary api calls that's needed at the background on app launch.

## What is not finished

- The widget test in `test/widget_test.dart` is still the generated counter test. It does not match this app.
- The splash screen stays in place, and need user to click the button instead of running on it's own.
- Product See More reviews screen is not developed. See more button is just a dummy

## AI Assistance

There are a few areas that AI is used for assistance. A few of them is commented in code

- Implementation of Cubit and Bloc (Other than reading the documentation)
- In `product_detail_models.dart` An error prevented me from opening product detail page. The issue being the json is List<dynamic> but I declared by variables as List<ReviewModel> and List<String>. Not sure how to resolve it, I seek AI Assistance
- In `route_paths.dart`, I know how, and should send id parameter to product details screen, but I don't know how to pass the parameter through routes, hence seek AI Assistance.
- I asked AI for help on how to write `README.md`, from what to write, and how to structure my documents, since I never wrote a README document before.
