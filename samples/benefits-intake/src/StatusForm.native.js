import React from 'react';
import { View, Button } from 'react-native';

import t from 'tcomb-form-native';

const { Form } = t.form;

const StatusStruct = t.struct({
  guid: t.String,
});

export default class StatusForm extends React.Component {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit() {
    const { guid } = this.form.getValue();
    const { setGuid } = this.props;
    setGuid(guid);
  }

  render() {
    return (
      <View>
        <Form
          ref={(c) => { this.form = c; }}
          type={StatusStruct}
        />
        <Button
          title="Get Status"
          onPress={this.handleSubmit}
        />
      </View>
    );
  }
}
