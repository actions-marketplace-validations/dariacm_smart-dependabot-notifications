# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x     | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please report it by creating a [private security advisory](https://github.com/dariacm/smart-dependabot-notifications/security/advisories/new) on GitHub.

**Please do not report security vulnerabilities through public GitHub issues.**

This is a personal project maintained in my spare time, but I take security seriously and will address issues as soon as I'm able.

## Security Best Practices

When using this action:

1. Always use the default `${{ github.token }}` or a token with minimal required permissions
2. Only grant the following required permissions:
   - `pull-requests: write` - To request reviewers and post comments on PRs
   - `actions: read` - To retrieve workflow run information and check if it was triggered by dependabot
3. Keep the action version pinned to a specific release tag (e.g., `@v1.0.0`) rather than using `@main`
4. Regularly update to the latest version to receive security patches
