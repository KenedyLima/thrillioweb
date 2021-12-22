package thrillio.project.bgjobs;

import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

import thrillio.project.dao.BookmarkDao;
import thrillio.project.entities.Weblink;
import thrillio.project.entities.Weblink.DownloadStatus;
import thrillio.project.util.HttpConnect;
import thrillio.project.util.IOUtil;

public class WeblinkDownloader implements Runnable {

	public static BookmarkDao dao = new BookmarkDao();

	private final long TIME_FRAME = 3000000L;

	private boolean downloadAll = false;

	ExecutorService downloadExecutor = Executors.newFixedThreadPool(5);

	public WeblinkDownloader(boolean downloadAll) {
		this.downloadAll = downloadAll;
	}
	
	public static class Downloader<T extends Weblink> implements Callable<T> {

		private T weblink;

		public Downloader(T weblink) {
			this.weblink = weblink;
		}

		@Override
		public T call() {
			try {
				if (!weblink.getUrl().endsWith(".pdf")) {
					weblink.setDownloadStatus(DownloadStatus.FAILED);
					String htmlPage = HttpConnect.download(weblink.getUrl());
					weblink.setHtmlPage(htmlPage);
				} else {
					weblink.setDownloadStatus(DownloadStatus.NOT_ELEGIBLE);
				}
			} catch (MalformedURLException e) {
				e.printStackTrace();
			} catch (URISyntaxException e) {
				e.printStackTrace();
			}
			return weblink;
		}
	}

	@Override
	public void run() {
		while (!Thread.currentThread().isInterrupted()) {
			List<Weblink> weblinks = getWeblinks();

			if (weblinks.size() > 0) {
				download(weblinks);
			} else {
			}

			try {
				TimeUnit.SECONDS.sleep(15);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		downloadExecutor.shutdown();
	}

	private void download(List<Weblink> weblinks) {
		List<Downloader<Weblink>> tasks = getTasks(weblinks);
		List<Future<Weblink>> futures = new ArrayList<>();

		try {
			futures = downloadExecutor.invokeAll(tasks, TIME_FRAME, TimeUnit.NANOSECONDS);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		for (Future<Weblink> future : futures) {
			try {
				System.out.println("TryBlock Future For Loop");
				if (!future.isCancelled()) {
					Weblink weblink = future.get();
					String webPage = weblink.getHtmlPage();
					System.out.println("Get htmlPage");
					if (webPage != null) {
						IOUtil.write(webPage, weblink.getId());
						weblink.setDownloadStatus(DownloadStatus.SUCCESS);
						System.out.println("Weblink Success: " + weblink.getUrl());
					} else {
						System.out.println("Weblink not downloaded" + weblink);
					}
				}
			} catch (InterruptedException | ExecutionException e) {
				e.printStackTrace();
			}
		}
	}

	private List<Downloader<Weblink>> getTasks(List<Weblink> weblinks) {

		List<Downloader<Weblink>> tasks = new ArrayList<>();

		for (Weblink weblink : weblinks) {
			tasks.add(new Downloader<Weblink>(weblink));
		}

		return tasks;
	}

	private List<Weblink> getWeblinks() {
		List<Weblink> weblinks = new ArrayList<>();

		if (downloadAll) {
			weblinks = dao.getWebLinks();
			downloadAll = false;
		} else {
			weblinks = dao.getWeblinks(DownloadStatus.NOT_ATTEMPTED);
		}

		return weblinks;
	}

}