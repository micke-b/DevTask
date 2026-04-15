---
name: BlogRepository
description: This repository users PostService and CommentService to get data about posts and comments
swift-version: .v6
dependencies:
  api: []
  impl:
    - PostService
    - CommentService
  test-utils: []
resources:
    - impl: []
owner: micke-b
---

## BlogRepository

This is a sample feature spec, not used in this project, but can be used for scaffolding and generating feature/module structure and packaging, and as context for AI agents.

This is the BlogRepository feature, consisting of a public API, implementation, and test utilities. The service is responsible for fetching posts and comments using their respective services.
