from datetime import datetime
from elasticsearch import Elasticsearch

es = Elasticsearch([{'host': 'localhost', 'port': 9200}])

#es = Elasticsearch()

class ElasticObj():
	def __init__(self, index_name, type_name):
		self.index_name = index_name
		self.type_name = type_name

	def Create_Index_Date(self):
		doc = [
		{       'name': 'Kai',
        		'live': 'New_Taipei'
		},
		{       'name': 'Kam',
        		'live': 'Taipei'
		},
		{       	'name': 'Wei',
        		'live': 'New_Taipei'
		}
	 	 ]    	

		i = 1
		for item in doc:
			print "doc_num"
			res = es.index(index=self.index_name, doc_type=self.type_name, id=i, body=item)
			i+=1
	
	def delete(self, delete_id):
		es.delete(index=self.index_name, doc_type=self.type_name, id=delete_id)
	
	def post(self, post_id, item_new):
		es.index(index=self.index_name, doc_type=self.type_name, id=post_id, body=item_new)

	def update(self, update_id, item_update):
		es.update(index=self.index_name, doc_type=self.type_name, id=update_id, body=item_update)

	def get(self, get_id):
		result = es.get(index=self.index_name, doc_type=self.type_name, id=1)
		print result["hits"]["hits"]["_source"]
	
	def search_term(self):
		result = es.search(index=self.index_name, doc_type=self.type_name, body={"query":{"term":{"live":"taipei"}}})	
		for num_result in range(len(result['hits']['hits'])):
			print result['hits']['hits'][num_result]['_source']
	def search_wildcard(self):
		result_wildcard = es.search(index=self.index_name, doc_type=self.type_name, body={"query":{"wildcard":{"live":"t**"}}}) 
		#for num_result in range(len(result_wildcard['hits']['hits'])):
			#print result['hits']['hits'][num_result]
obj = ElasticObj("ntust", "ce")

#obj.Create_Index_Date()

#obj.delete(2)

new_Item = {
	'name': 'Jack Wu',
	'live': 'New_Taipei'
	}
#obj.post(4, new_Item)

update_Item = {
	'name': 'Jack',
	'live': 'Japan'
	}
#obj.update(4, update_Item)

#obj.get(2)
obj.search_term()
obj.search_wildcard()
