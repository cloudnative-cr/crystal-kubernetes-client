# Copyright 2025 Josephine Pfeiffer
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Kubernetes
  class Client
    # get available resources
    # GET /apis/batch/v1/
    def get_batch_v1_api_resources(**params, &)
      path = "/apis/batch/v1/"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind CronJob
    # GET /apis/batch/v1/cronjobs
    def list_batch_v1_cron_job_for_all_namespaces(**params, &)
      path = "/apis/batch/v1/cronjobs"
      get(path) { |res| yield res }
    end

    # list or watch objects of kind Job
    # GET /apis/batch/v1/jobs
    def list_batch_v1_job_for_all_namespaces(**params, &)
      path = "/apis/batch/v1/jobs"
      get(path) { |res| yield res }
    end

    # delete collection of CronJob
    # DELETE /apis/batch/v1/namespaces/{namespace}/cronjobs
    def delete_batch_v1_collection_namespaced_cron_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/cronjobs"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind CronJob
    # GET /apis/batch/v1/namespaces/{namespace}/cronjobs
    def list_batch_v1_namespaced_cron_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/cronjobs"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a CronJob
    # POST /apis/batch/v1/namespaces/{namespace}/cronjobs
    def create_batch_v1_namespaced_cron_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/cronjobs"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a CronJob
    # DELETE /apis/batch/v1/namespaces/{namespace}/cronjobs/{name}
    def delete_batch_v1_namespaced_cron_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/cronjobs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified CronJob
    # GET /apis/batch/v1/namespaces/{namespace}/cronjobs/{name}
    def read_batch_v1_namespaced_cron_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/cronjobs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified CronJob
    # PATCH /apis/batch/v1/namespaces/{namespace}/cronjobs/{name}
    def patch_batch_v1_namespaced_cron_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/cronjobs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified CronJob
    # PUT /apis/batch/v1/namespaces/{namespace}/cronjobs/{name}
    def replace_batch_v1_namespaced_cron_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/cronjobs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified CronJob
    # GET /apis/batch/v1/namespaces/{namespace}/cronjobs/{name}/status
    def read_batch_v1_namespaced_cron_job_status(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/cronjobs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified CronJob
    # PATCH /apis/batch/v1/namespaces/{namespace}/cronjobs/{name}/status
    def patch_batch_v1_namespaced_cron_job_status(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/cronjobs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified CronJob
    # PUT /apis/batch/v1/namespaces/{namespace}/cronjobs/{name}/status
    def replace_batch_v1_namespaced_cron_job_status(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/cronjobs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # delete collection of Job
    # DELETE /apis/batch/v1/namespaces/{namespace}/jobs
    def delete_batch_v1_collection_namespaced_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/jobs"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # list or watch objects of kind Job
    # GET /apis/batch/v1/namespaces/{namespace}/jobs
    def list_batch_v1_namespaced_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/jobs"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # create a Job
    # POST /apis/batch/v1/namespaces/{namespace}/jobs
    def create_batch_v1_namespaced_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/jobs"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      post(path, params) { |res| yield res }
    end

    # delete a Job
    # DELETE /apis/batch/v1/namespaces/{namespace}/jobs/{name}
    def delete_batch_v1_namespaced_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/jobs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      delete(path) { |res| yield res }
    end

    # read the specified Job
    # GET /apis/batch/v1/namespaces/{namespace}/jobs/{name}
    def read_batch_v1_namespaced_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/jobs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update the specified Job
    # PATCH /apis/batch/v1/namespaces/{namespace}/jobs/{name}
    def patch_batch_v1_namespaced_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/jobs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace the specified Job
    # PUT /apis/batch/v1/namespaces/{namespace}/jobs/{name}
    def replace_batch_v1_namespaced_job(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/jobs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # read status of the specified Job
    # GET /apis/batch/v1/namespaces/{namespace}/jobs/{name}/status
    def read_batch_v1_namespaced_job_status(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/jobs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # partially update status of the specified Job
    # PATCH /apis/batch/v1/namespaces/{namespace}/jobs/{name}/status
    def patch_batch_v1_namespaced_job_status(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/jobs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      patch(path, params) { |res| yield res }
    end

    # replace status of the specified Job
    # PUT /apis/batch/v1/namespaces/{namespace}/jobs/{name}/status
    def replace_batch_v1_namespaced_job_status(**params, &)
      path = "/apis/batch/v1/namespaces/{namespace}/jobs/{name}/status"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      put(path, params) { |res| yield res }
    end

    # watch individual changes to a list of CronJob. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/batch/v1/watch/cronjobs
    def watch_batch_v1_cron_job_list_for_all_namespaces(**params, &)
      path = "/apis/batch/v1/watch/cronjobs"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of Job. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/batch/v1/watch/jobs
    def watch_batch_v1_job_list_for_all_namespaces(**params, &)
      path = "/apis/batch/v1/watch/jobs"
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of CronJob. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/batch/v1/watch/namespaces/{namespace}/cronjobs
    def watch_batch_v1_namespaced_cron_job_list(**params, &)
      path = "/apis/batch/v1/watch/namespaces/{namespace}/cronjobs"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind CronJob. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/batch/v1/watch/namespaces/{namespace}/cronjobs/{name}
    def watch_batch_v1_namespaced_cron_job(**params, &)
      path = "/apis/batch/v1/watch/namespaces/{namespace}/cronjobs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch individual changes to a list of Job. deprecated: use the 'watch' parameter with a list operation instead.
    # GET /apis/batch/v1/watch/namespaces/{namespace}/jobs
    def watch_batch_v1_namespaced_job_list(**params, &)
      path = "/apis/batch/v1/watch/namespaces/{namespace}/jobs"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end

    # watch changes to an object of kind Job. deprecated: use the 'watch' parameter with a list operation instead, filtered to a single item with the 'fieldSelector' parameter.
    # GET /apis/batch/v1/watch/namespaces/{namespace}/jobs/{name}
    def watch_batch_v1_namespaced_job(**params, &)
      path = "/apis/batch/v1/watch/namespaces/{namespace}/jobs/{name}"
      params.each { |k, v| path = path.gsub("{#{k}}", v.to_s) }
      get(path) { |res| yield res }
    end
  end
end
