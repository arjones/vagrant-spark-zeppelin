/**
 * Created by arjones on 9/12/15.
 */
trait DummyLog {
  println("\n" * 3)
  println("=" * 35)
  println(s"Entering class ${this.getClass.getSimpleName}")
}
