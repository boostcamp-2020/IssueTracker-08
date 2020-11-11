import * as config from '../config';

export const GET_AUTH = config.BASE_URL + 'auth/';

export const POST_ISSUE = config.BASE_URL + 'api/issues';

export const GET_LABELS = config.BASE_URL + 'api/labels';

export const DELETE_LABELS = (id) => config.BASE_URL + 'api/labels/' + id;
