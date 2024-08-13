---
title: Tool support
description: Ollama now supports tool calling with popular models such as Llama 3.1. This enables a model to answer a given prompt using tool(s) it knows about, making it possible for models to perform more complex tasks or interact with the outside world.
publishDate: 2024-07-14
cover: header.png
---
Example tolls include:

<!-- List test: OK -->
- Functions an APIs
- Web browsing
- Code interpreter
- much more!

<!-- Gif test: OK-->
<!-- ![gif test](https://media.giphy.com/media/vFKqnCdLPNOKc/giphy.gif) -->

<!-- Video test: OK -->
<video controls autoplay>
    <source src="https://github.com/user-attachments/assets/aea4d7c1-f1be-41fd-9077-023d37a9d052" type="video/mp4">
</video>

<!-- Headers test: OK -->
### Tool calling

<!-- Code inside paragraph: OK -->
To enable tool calling, provide a list of available tools via the `tools` field in Ollama's API.

<!-- Code block: OK  -->
```python
import ollama

response = ollama.chat(
    model='llama3.1',
    messages=[{'role': 'user', 'content':
        'What is the weather in Toronto?'}],

		# provide a weather checking tool to the model
    tools=[{
      'type': 'function',
      'function': {
        'name': 'get_current_weather',
        'description': 'Get the current weather for a city',
        'parameters': {
          'type': 'object',
          'properties': {
            'city': {
              'type': 'string',
              'description': 'The name of the city',
            },
          },
          'required': ['city'],
        },
      },
    },
  ],
)

print(response['message']['tool_calls'])
```

<!-- Link test: OK -->
Supported models will now answer with a `tool_calls` response.
Tool responses can be provided via messages with the `tool` role.
See [API documentation](https://github.com/ollama/ollama/blob/main/docs/api.md#chat-request-with-tools) for more information.

### Supported models

 A list of supported models can be found under the [Tools category on the models page](https://ollama.com/search?c=tools):

 - [Llama 3.1](https://ollama.com/library/llama3.1)
 - [Mistral Nemo](https://ollama.com/library/mistral-nemo)
 - [Firefunction v2](https://ollama.com/library/firefunction-v2)
 - [Command-R +](https://ollama.com/library/command-r-plus)

<!-- Blockquote support: OK -->
> Note: please check if you have the latest models by running `ollama pull <model>`

![ollama.com tool models](https://ollama.com/public/blog/model-page-tools.png)

## OpenAI compatibility

Ollama's OpenAI compatible endpoint also now supports tools, making it possible to switch to using Llama 3.1 and other models.

```python
import openai

openai.base_url = 'http://localhost:11434/v1&'
openai.api_key = 'ollama'

response = openai.chat.completions.create(
	model=&quot;llama3.1&quot;,
	messages=messages,
	tools=tools,
)
```

### Full examples

- [Python](https://github.com/ollama/ollama-python/blob/main/examples/tools/main.py)
- [JavaScript](https://github.com/ollama/ollama-js/blob/main/examples/tools/tools.ts)

### Future improvements

- Streaming tool calls: stream tool calls back to begin taking action faster when multiple tools are returned
- Tool choice: force a model to use a tool

### Let's build together

We are so excited to bring you tool support, and see what you build with it!

If you have any feedback, please do not hesitate to tell us either in our [Discord](https://discord.com/invite/ollama)!
