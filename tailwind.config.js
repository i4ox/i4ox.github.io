/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
        './source/**/*.jinja',
    ],
    plugins: [
        require('@tailwindcss/typography'),
    ],
}
