module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
    ...(process.env.RAILS_ENV === "production"
      ? {
          "@fullhuman/postcss-purgecss": {
            content: [
              "./app/**/*.html.erb",
              "./app/helpers/**/*.rb",
              "./app/javascript/**/*.js",
            ],
            defaultExtractor: (content) =>
              content.match(/[A-Za-z0-9-_:/]+/g) || [],
          },
        }
      : {}),
  },
};
