import React from 'react';
import {
  StyleSheet, Text, View, TouchableOpacity,
} from 'react-native';
import Banner from './src/Banner';
import Form from './src/Form';
import Status from './src/Status';
import api from './src/api';

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'lightgray',
    alignItems: 'center',
  },
  btnContainer: {
    backgroundColor: 'white',
    width: '90%',
    flex: 1,
    alignItems: 'center',
    justifyContent: 'space-around',
  },
  btn: {
    backgroundColor: '#4299e1',
    width: '50%',
    alignItems: 'center',
    justifyContent: 'center',
    borderRadius: 2,
    height: '10%',
  },
  btnText: {
    color: 'white',
  },
});

function metadataFromState(state) {
  return {
    verteranFirstName: state.firstName,
    veteranLastName: state.lastName,
    fileNumber: state.fileNumber,
    source: 'va-gov-document-uploader',
    docType: state.docType,
  };
}

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      status: 'loaded',
    };
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit(formState) {
    console.log(formState);
    this.setState({ status: 'submitting' });
    console.log(metadataFromState(formState));
    api.actions.uploadDocument(metadataFromState(formState), formState.files).then((results) => {
      console.log(results);
    });
  }

  render() {
    const { status } = this.state;
    let content = null;
    switch (status) {
      case 'documentStatus': {
        content = (
          <Status />
        );
        break;
      }
      case 'newDocument': {
        content = (
          <Form handleSubmit={this.handleSubmit} />
        );
        break;
      }
      default: {
        content = (
          <View style={styles.btnContainer}>
            <TouchableOpacity style={styles.btn} onPress={() => this.setState({ status: 'documentStatus' })}>
              <Text style={styles.btnText}> View Document Status </Text>
            </TouchableOpacity>
            <TouchableOpacity style={styles.btn} onPress={() => this.setState({ status: 'newDocument' })}>
              <Text style={styles.btnText}> Upload New Document </Text>
            </TouchableOpacity>

          </View>
        );
      }
    }
    return (
      <View style={styles.container}>
        <Banner />
        {content}
      </View>
    );
  }
}
