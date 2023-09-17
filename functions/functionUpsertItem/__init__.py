import logging

import azure.functions as func


def main(req: func.HttpRequest, functionUpsertItem: func.Out[func.SqlRow]) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    try:
        body = req.get_json()
        row = func.SqlRow.from_dict(body)
        functionUpsertItem.set(row)
        return func.HttpResponse(
            "This HTTP triggered function executed successfully.",
            status_code=200
        )

    except ValueError:
        return func.HttpResponse(
            "The server cannot or will not process the request due to something that is perceived to be a client error",
            status_code=400
        )
