import React from 'react';
import { View, StyleSheet, Button } from 'react-native';
import * as DocumentPicker from 'expo-document-picker';
import * as FileSystem from 'expo-file-system';
import t from 'tcomb-form-native';

const FormStruct = t.struct({
  docType: t.String,
  firstName: t.String,
  lastName: t.String,
  fileNumber: t.String,
});

const TForm = t.form.Form;

const styles = StyleSheet.create({
  container: {
    backgroundColor: 'white',
    width: '90%',
    justifyContent: 'center',
    padding: 20,
    marginTop: 50,
  },
  webview: {
  },
});

export default class Form extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      file: null,
    };
    this.buildData = this.buildData.bind(this);
    this.pickDocument = this.pickDocument.bind(this);
  }

  pickDocument(e) {
    e.preventDefault();

    const picker = DocumentPicker.getDocumentAsync({ type: '*/*' });
    picker.then((pickResult) => {
      FileSystem.readAsStringAsync(pickResult.uri).then((readResult) => {
        this.setState({ file: readResult });
      });
    });
  }

  buildData() {
    const { handleSubmit } = this.props;
    const { file } = this.state;
    const data = Object.assign({}, this.form.getValue());
    data.files = [file];
    handleSubmit(data);
  }

  render() {
    return (
      <View style={styles.container}>
        <Button
          title="Pick a document"
          onPress={this.pickDocument}
        />
        <TForm
          ref={(c) => { this.form = c; }}
          type={FormStruct}
        />
        <Button
          title="Upload files to VA"
          onPress={this.buildData}
        />
      </View>
    );
  }
}
