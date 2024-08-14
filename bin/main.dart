import 'package:static_shock/static_shock.dart';

Future<void> main(List<String> arguments) async {
  // Configure the static website generator.
  final staticShock = StaticShock()
    ..pickRemote(
      assets: {
        RemoteFile(
          url:
              'https://cdn1.iconfinder.com/data/icons/tidee-halloween/24/021_027_cat_black_witch_halloween-256.png',
          buildPath: FileRelativePath("images/", "preview", "png"),
        ),
        RemoteFile(
          url:
              'https://cdn1.iconfinder.com/data/icons/tidee-halloween/24/021_028_cat_black_witch_halloween-256.png',
          buildPath: FileRelativePath("images/", "logo", "png"),
        ),
      },
    )
    // Here, you can directly hook into the StaticShock pipeline. For example,
    // you can copy an "images" directory from the source set to build set:
    ..pick(ExtensionPicker("html"))
    ..pick(ExtensionPicker("jpeg"))
    ..pick(ExtensionPicker("png"))
    ..pick(DirectoryPicker.parse("images"))
    // All 3rd party behavior is added through plugins, even the behavior
    // shipped with Static Shock.
    ..plugin(const MarkdownPlugin())
    ..plugin(const JinjaPlugin())
    ..plugin(SassPlugin())
    ..plugin(const PrettyUrlsPlugin())
    ..plugin(const RedirectsPlugin())
    ..plugin(DraftingPlugin(
      showDrafts: arguments.contains("preview"),
    ))
    ..plugin(RssPlugin(
      site: RssSiteConfiguration(
        title: "blog",
        description: "blog",
        homePageUrl: "",
      ),
      pageToRssItemMapper: (RssSiteConfiguration config, Page page) {
        return defaultPageToRssItemMapper(config, page)?.copyWith(
          author: page.data["author"],
        );
      },
    ))
    ..plugin(TailwindPlugin(
      input: "source/styles/tailwind.css",
      output: "build/styles/tailwind.css",
    ));

  // Generate the static website.
  await staticShock.generateSite();
}
