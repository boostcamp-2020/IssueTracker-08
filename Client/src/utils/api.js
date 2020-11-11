import * as config from '../config';

export const GET_ISSUE = (id) => config.BASE_URL + 'api/issues/' + id;
export const POST_ISSUE = config.BASE_URL + 'api/issues';
