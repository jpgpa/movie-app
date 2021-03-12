# Movie App Showcase

This is a simple showcase app so you can see how you can add things like Hero and Swiper widget into flutter apps. You can also see the way I structured the project so i can fetch data from a movie API.

## Before you start

Before you start you should create a developer account on TheMovieDB page
[TheMovieDB developers page](https://developers.themoviedb.org/4/getting-started/authorization)

and then get an API key so you can fetch the data you want.

You should then use the **API key** on your requests including it in your header. Here i'm using http package for fetching data from the API:

```dart
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer ${MovieDbClient.api_key}'
      },
    );

    if (response.statusCode == 200) {
      return MovieList.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
```

here you can see the result:
[result](https://media.giphy.com/media/ETWTvogWEXTGZcUMeK/giphy.gif)

Packages/Widgets used in this showcase:

- flutter_bloc for handling app state;
- flutter_swiper for the movie swiper;
- loading_skeleton for showing loading widgets;
- http for fetching data from the internet;
- get_it for service locator.

The loading package I'm using on this showcase was created by me so if you have the time go check it out:

- [Github - Loading Skeleton](https://github.com/jpgpa/loading_skeleton_widget)
- [Pub.dev - Loading Skeleton](https://pub.dev/packages/loading_skeleton)