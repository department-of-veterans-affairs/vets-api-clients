import React from 'react';
import {
  View, StyleSheet, Text,
} from 'react-native';
import StatusForm from './StatusForm';

import api from './api';

const styles = StyleSheet.create({
  container: {
    backgroundColor: 'white',
    width: '90%',
    justifyContent: 'center',
    padding: 20,
    marginTop: 50,
  },
  codeBlock: {
    backgroundColor: 'lightblue',
    padding: 20,
    marginTop: 20,
  },
  header: {
    fontSize: 20,
    marginBottom: 20,
  },
});

export default class Status extends React.Component {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.state = {
      response: null,
    };
  }

  handleSubmit(guid) {
    api.actions.getUploadStatus(guid).then((resp) => {
      this.setState({ response: resp });
    });
  }

  render() {
    const { response } = this.state;
    return (
      <View style={styles.container}>
        <Text style={styles.header}>Enter Guid to get status</Text>
        <StatusForm setGuid={this.handleSubmit} guid={this.props.guid} />
        {response
            && (
            <View style={styles.codeBlock}>
              <Text>{JSON.stringify(response, null, 2)}</Text>
            </View>
            )
        }
      </View>
    );
  }
}
