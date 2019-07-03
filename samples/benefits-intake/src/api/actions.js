import { UPLOAD_ENDPOINT } from './routes';

function apiRequest(location, optionOverrides) {
  const defaultOptions = {
    method: 'GET',
    headers: {
      apikey: process.env.API_KEY,
    },
  };

  const options = Object.assign({}, defaultOptions, optionOverrides);

  return fetch(location, options)
    .then(response => response.json());
}

const postRequest = {
  method: 'POST',
};

export function getLocation() {
  return apiRequest(UPLOAD_ENDPOINT, postRequest);
}

export function getUploadStatus(guid) {
  return apiRequest(`${UPLOAD_ENDPOINT}/${guid}`);
}

export function uploadDocument(metadata, files) {
  getLocation().then((locationRes) => {
    const { location, guid } = locationRes.data.attributes;

    const data = new FormData();
    data.append('metadata', metadata);

    files.forEach((file, i) => {
      const name = i === 0 ? 'content' : `attachment${i}`;
      data.append(name, file);
    });

    fetch(location, { method: 'PUT', body: data })
      .then(() => {
        getUploadStatus(guid).then((statusResponse) => {
          const { status } = statusResponse.data.attributes;
          console.log(status);
        });
      });
  });
}
