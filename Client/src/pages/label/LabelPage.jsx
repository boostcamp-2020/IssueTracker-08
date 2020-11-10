import React, { useState } from 'react';
import Container from '../../components/shared/container/Container';
import ItemContainer from '../../components/shared/container/ItemContainer';
import ItemHeader from '../../components/shared/container/ItemHeader';
import Title from '../../components/shared/text/Title';
import Menu from '../../components/shared/container/Menu';
import LabelList from '../../components/label/LabelList';
import useFetch from '../../hooks/useFetch';

import { GET_LABELS } from '../../utils/api';
import { getOptions } from '../../utils/fetchOptions';

export default function LabelPage() {
  const [labels, setLabels] = useState([]);

  const loading = useFetch(setLabels, GET_LABELS, getOptions);

  return (
    <Container>
      <Menu name="label" link="/label"></Menu>
      <ItemContainer>
        <ItemHeader>
          <Title text={labels.length + ' labels'} />
        </ItemHeader>
        <LabelList labels={labels} loading={loading} />
      </ItemContainer>
    </Container>
  );
}
