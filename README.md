# terraform-publish-module-buildkite-plugin

A Buildkite module to validate Terrafrom repositories. 

The plugin will publish to Terraform cloud by tagging a branch. The plugin will append a `-dev` suffix to a branch that is not the main branch.

To use the plugin, append the following to your buildkite pipeline.
```
steps:
    # other steps...

  - label: " :terraform: Deploy to Terraform Registry"
    env:
    plugins:
      - jvrck/terraform-publish-module:
```