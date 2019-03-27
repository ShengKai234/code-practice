package org.iii.dao.es;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.elasticsearch.action.delete.DeleteResponse;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.TermQueryBuilder;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.elasticsearch.search.aggregations.bucket.terms.TermsAggregationBuilder;
import org.elasticsearch.transport.client.PreBuiltTransportClient;
import org.json.JSONException;

public class appDAO {

	private TransportClient client;
	private String CLUSTER_NAME;
	private String INDEX;
	private String TYPE;

	@SuppressWarnings("resource")
	public appDAO(String HOST_IP, int HOST_PORT, String CLUSTER_NAME, String INDEX_3APP, String TYPE_3APP) {
		this.CLUSTER_NAME = CLUSTER_NAME;
		this.INDEX = INDEX_3APP;
		this.TYPE = TYPE_3APP;
		Settings esSettings = Settings.builder().put("cluster.name", CLUSTER_NAME).build();

		try {
			client = new PreBuiltTransportClient(esSettings)
					.addTransportAddress(new InetSocketTransportAddress(InetAddress.getByName(HOST_IP), HOST_PORT));
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public Terms get3App(String querystring , String latestTime ) {
		

		TermQueryBuilder termquery = QueryBuilders.termQuery("crawlerDatetime", latestTime);
		BoolQueryBuilder bq = new BoolQueryBuilder();
		bq.must(termquery);
		 
		
		TermsAggregationBuilder aggbuilder1 = AggregationBuilders.terms("_clientId").field("clientId.keyword")
				.size(Integer.MAX_VALUE);
		TermsAggregationBuilder aggbuilder2 = AggregationBuilders.terms("_users").field("username.keyword")
				.size(Integer.MAX_VALUE);
		aggbuilder1.subAggregation(aggbuilder2);
		SearchRequestBuilder search = client.prepareSearch(INDEX).setTypes(TYPE).addAggregation(aggbuilder1);

		if (querystring != null) {
			BoolQueryBuilder bq2 = QueryBuilders.boolQuery().must(QueryBuilders.queryStringQuery(querystring));
			bq.must(bq2);
			
		}
		search.setQuery(bq);

		SearchResponse response = search.execute().actionGet();
		Terms terms = response.getAggregations().get("_clientId");
		return terms;
	}

	public String getLatestTime() {
		String getLatestTime = "";
		TermsAggregationBuilder aggbuilder1 = AggregationBuilders.terms("_date").field("crawlerDatetime")
				.size(Integer.MAX_VALUE);

		SearchRequestBuilder search = client.prepareSearch(INDEX).setTypes(TYPE).addAggregation(aggbuilder1);

		SearchResponse response = search.execute().actionGet();
		Terms terms = response.getAggregations().get("_date");

		if (terms.getBuckets().size() > 0)

		{
			Terms.Bucket entry = terms.getBuckets().get(0);
			getLatestTime = entry.getKeyAsString();

		}
		return getLatestTime;

	}

	public Terms getUsers(String domain) {

		TermQueryBuilder termDomain = QueryBuilders.termQuery("domain.keyword", domain);
		BoolQueryBuilder bq = new BoolQueryBuilder();
		bq.must(termDomain);

		TermsAggregationBuilder aggbuilder1 = AggregationBuilders.terms("_users").field("username.keyword")
				.size(Integer.MAX_VALUE);
		SearchRequestBuilder search = client.prepareSearch(INDEX).setTypes(TYPE)
				.setQuery(QueryBuilders.boolQuery().must(bq)).addAggregation(aggbuilder1);
		SearchResponse response = search.execute().actionGet();
		Terms terms = response.getAggregations().get("_users");
		return terms;
	}

	public Terms getIsAdmin() {
		String querystring = "(isAdmin:true || isDelegatedAdmin:true)";

		TermsAggregationBuilder aggbuilder1 = AggregationBuilders.terms("_clientId").field("clientId.keyword")
				.size(Integer.MAX_VALUE);
		SearchRequestBuilder search = client.prepareSearch(INDEX).setTypes(TYPE).addAggregation(aggbuilder1);

		BoolQueryBuilder bq = QueryBuilders.boolQuery().must(QueryBuilders.queryStringQuery(querystring));
		search.setQuery(bq);
		SearchResponse response = search.execute().actionGet();
		Terms terms = response.getAggregations().get("_clientId");
		return terms;
	}

	public SearchHit getAppInfo(String clientId, String domain) throws JSONException {

		int from = 0;
		int size = 1;

		TermQueryBuilder termDomain = QueryBuilders.termQuery("domain.keyword", domain);
		TermQueryBuilder termClientId = QueryBuilders.termQuery("clientId.keyword", clientId);

		BoolQueryBuilder bq = new BoolQueryBuilder();
		bq.must(termDomain);
		bq.must(termClientId);

		SearchRequestBuilder search = client.prepareSearch(INDEX).setTypes(TYPE).setQuery(bq).setFrom(from)
				.setSize(size);
		//

		SearchResponse response = search.execute().actionGet();
		SearchHits hits = response.getHits();
		return hits.getAt(0);
	}

	public void deleteApp(String clientId, String username, String domain) {
		clientId = clientId.replace(" ", "\\ ");
		// String querystring = "(domain:" + domain + ") AND (clientId:" + clientId + ")
		// AND (username:" + username + ")";

		TermQueryBuilder termDomain = QueryBuilders.termQuery("domain.keyword", domain);
		TermQueryBuilder termClientId = QueryBuilders.termQuery("clientId.keyword", clientId);

		BoolQueryBuilder bq = new BoolQueryBuilder();
		bq.must(termDomain);
		bq.must(termClientId);
		SearchResponse response = client.prepareSearch(INDEX).setTypes(TYPE).setQuery(bq).setSize(10000).execute()
				.actionGet();

		for (SearchHit item : response.getHits().getHits()) {
			DeleteResponse res = client.prepareDelete(INDEX, TYPE, item.getId()).get();
		}

	}

}
