FROM python:3.12.4-slim
WORKDIR /app

RUN adduser --disabled-password --gecos '' appuser

RUN pip install poetry && poetry config virtualenvs.create false

# dependencies
COPY pyproject.toml poetry.lock ./
RUN poetry install --no-dev

USER appuser
COPY heimdallr ./heimdallr
COPY main.py ./

ARG HEIMDALLR_VERSION
ENV HEIMDALLR_VERSION=$HEIMDALLR_VERSION
ARG COMMIT_ID
ENV COMMIT_ID=$COMMIT_ID

CMD ["python", "main.py"]